local REF_PATTERN = "^%s*<<([^%s<>]+)>>$"

function CodeBlock(block)
  local pieces = {}
  local buffer = {}

  local function flush_link(line, ref)
     local class_attr = ""
     if #block.classes > 0 then
        class_attr = ' class="' .. table.concat(block.classes, " ") .. '"'
     end
     local escaped = line:gsub("<", "&lt;"):gsub(">", "&gt;")
     local html =
        '<pre><code' .. class_attr .. '><a href="#' ..
        ref .. '">' .. escaped .. '</a></code></pre>'
     table.insert(pieces, pandoc.RawBlock("html", html))
  end

  local function flush()
    if #buffer > 0 then
      local text = table.concat(buffer, "\n")
      table.insert(pieces,
        pandoc.CodeBlock(text, pandoc.Attr("", block.classes, block.attributes)))
      buffer = {}
    end
  end

  for line in (block.text .. "\n"):gmatch("([^\n]*)\n") do
    local ref = string.match(line, REF_PATTERN)
    if ref then
      flush()
      flush_link(line, ref)
    else
      table.insert(buffer, line)
    end
  end
  flush()

  return pandoc.Blocks(pieces)
end

function CodeBlock(el)
  if el.classes:includes("result") then
    local path = el.text:gsub("^%s*(.-)%s*$", "%1")
    local f = io.open(path, "r")
    if not f then
      return pandoc.CodeBlock("(not yet run: " .. path .. ")", {"text"})
    end
    local content = f:read("*all"):gsub("%s*$", "")
    f:close()
    local lang = content:match("^%s*[{%[]") and "json" or "text"
    return pandoc.CodeBlock(content, {lang})
  end
end
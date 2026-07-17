local function append_blocks(dst, src)
   for _, b in ipairs(src) do
      table.insert(dst, b)
   end
end

local function wrap_in_details(content, summary_label, lang)
   local summary = pandoc.Plain(
      pandoc.RawInline("html", "<summary>" .. summary_label .. "</summary>")
   )
   local code    = pandoc.CodeBlock(content, pandoc.Attr("", {lang}))
   local div     = pandoc.Div({summary, code}, pandoc.Attr("", {"details"}))
   return {
      pandoc.RawBlock("html",  "<details><summary>" .. summary_label .. "</summary>"),
      pandoc.CodeBlock(content, pandoc.Attr("", {lang})),
      pandoc.RawBlock("html", "</details>"),
   }
end

local function read_file(path)
   local f = io.open(path, "r")
   if not f then return nil end
   local content = f:read("*all")
   f:close()
   return content
end

function CodeBlock(el)
   if el.classes:includes("hurl") and el.attributes["file"] then
      local hurl_path = el.attributes["file"]
      local basename = hurl_path:match("([^/]+)%.hurl$") or hurl_path
      local result_path = "tests/results/" .. basename .. ".txt"
      local curl_path = "tests/results/" .. basename .. ".curl"
      local blocks = { el }

      local curl = read_file(curl_path)
      if curl then
         append_blocks(blocks, wrap_in_details(curl, "curl", "bash"))
      end

      local result = read_file(result_path)
      if result then
         local lang = result:match("^%s*[{%[]") and "json" or "text"
         append_blocks(blocks, wrap_in_details(result, "result", lang))
      end

      return pandoc.Blocks(blocks)
   end
end

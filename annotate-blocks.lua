function Pandoc(doc)
   table.insert(
      doc.blocks,
      1,
      pandoc.RawBlock(
         "html",
         "<style>div.sourceCode { margin: 0; }</style>"))
   return doc
end

function CodeBlock(el)
  local id = el.identifier
  local file = el.attributes["file"]
  local has_id = id ~= nil and id ~= ""
  local has_file = file ~= nil and file ~= ""

  if not has_id and not has_file then
     return nil
  end

  local parts = {}
  if has_id then
     table.insert(parts, "#" .. id)
  end
  if has_file then
     table.insert(parts, "file:" .. file)
  end

  local fieldset_id = has_id and id or file
  local legend = table.concat(parts, "&emsp;")
  local open =
     pandoc.RawBlock(
        "html",
        "<fieldset id=" .. fieldset_id .. "><legend>" .. legend .. "</legend>")
  local close = pandoc.RawBlock("html", "</fieldset>")
  return pandoc.Blocks({ open, el, close })
end

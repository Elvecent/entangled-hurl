function CodeBlock(el)
  if el.identifier and el.identifier ~= "" then
    local open =
      pandoc.RawBlock("html", "<fieldset><legend>" .. el.identifier .. "</legend>")
    local close = pandoc.RawBlock("html", "</fieldset>")
    return pandoc.Blocks({ open, el, close })
  end
end
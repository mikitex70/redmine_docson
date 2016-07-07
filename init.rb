Redmine::Plugin.register :redmine_docson do
  name 'Redmine Docson plugin'
  author 'Michele Tessaro'
  description 'Wiki macro plugin for inserting docson widgets in Wiki pages and Issues'
  version '0.0.1'
  url 'https://github.com/mikitex70/redmine_docson'
  #author_url 'http://example.com/about'

  Redmine::WikiFormatting::Macros.register do
    desc <<EOF
      Docson widget plugin. Example usage:
      
      {{docson(path/to/json/schema)}}

      JSON schema path must be relative to redmine public folder.
EOF

    macro :docson do |obj, args|
      content = "<script src=\"/docson/widget.js\" data-schema=\"/jsonSchemas/#{args[0]}\"></script>"

      return "#{CGI::unescapeHTML(content)}".html_safe
    end
  end
end

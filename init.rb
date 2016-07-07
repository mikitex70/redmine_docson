Rails.logger.info 'Avvio del mio plugin'

Redmine::Plugin.register :redmine_docson do
  name 'Redmine Docson plugin'
  author 'Michele Tessaro'
  description 'Wiki macro plugin for inserting docson widgets in Wiki pages'
  version '0.0.1'
  #url 'http://example.com/path/to/plugin'
  #author_url 'http://example.com/about'

  Rails.logger.info 'Mio plugin registrato'

  Redmine::WikiFormatting::Macros.register do
    desc <<EOF
      Docson widget plugin. Example usage:
      
      {{docson(path/to/json/schema)}}

      JSON schema path must be relative to redmine and without ".json" extension.
EOF

    macro :docson do |obj, args|
      Rails.logger.info 'Macro chiamata'
      content = "<script src=\"/docson/widget.js\" data-schema=\"/jsonSchemas/#{args[0]}\"></script>"

      return "#{CGI::unescapeHTML(content)}".html_safe
    end
  end
end

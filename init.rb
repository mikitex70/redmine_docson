Redmine::Plugin.register :redmine_docson do
  name 'Redmine Docson plugin'
  author 'Michele Tessaro'
  description 'Wiki macro plugin for inserting docson widgets into Wiki pages and Issues'
  version '0.1.2'
  url 'https://github.com/mikitex70/redmine_docson'
  author_url 'https://github.com/mikitex70'

  requires_redmine version: '2.6'..'3.4'
  
  settings(partial: 'settings/docson_settings', 
           default: {'docson_web_path' => '/docson', 'docson_schemas_path' => '/jsonSchemas'})

  Redmine::WikiFormatting::Macros.register do
    desc <<EOF
      Docson widget plugin. Example usage:
      
      {{docson(path/to/json/schema)}}

      JSON schema path must be relative to redmine public folder.
EOF

    macro :docson do |obj, args|
      content = "<script src=\"#{Setting.plugin_redmine_docson['docson_web_path']}/widget.js\" data-schema=\"#{Setting.plugin_redmine_docson['docson_schemas_path']}/#{args[0]}\"></script>"

      return CGI::unescapeHTML(content).html_safe
    end
  end
end

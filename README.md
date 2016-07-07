# Docson Redmine plugin

Docson is a tool that can render JSON schemas in a more human readable format, embedded in web pages.

This plugin will allow adding [Docson](https://github.com/lbovet/docson) widgets into Redmine wiki pages and issues.

## Requirements

- download docson into directory `$REDMINE_HOME/public`. For example:

  ```
  cd $REDMINE_HOME
  git clone https://github.com/lbovet/docson.git
  ```

- install redmine_docson plugin:

  ```
  cd $REDMINE_HOME
  git clone https://github.com/mikitex70/redmine_docson.git
  ```

- restart Redmine to load the new plugin

## USAGE

- put your JSON schemas in a folder under $REDMINE_HOME/public. It is important that docson and JSON schemas are on the same server to avoid cross-origin issues.

- in Wiki pages use the `docson` macro to load the widget, specifing the path of the JSON schema relative to the public folder. For example:

  ```
  {{docson(myService/response)}}
  ```
  
## Known issues

- Docson widgets are not rendered inside a PDF export: widgets are rendered on the HTML page using Javascript and cannot be rendered in PDF. As workaround you can print the web page as PDF document (easy with Linux, a bit more problematic in Windows).

## TODO

- add a configuration form to allow specify paths for the docson installation and the JSON schemas folder.

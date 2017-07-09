# Docson Redmine plugin

[Docson](https://github.com/lbovet/docson) is a tool that can render JSON schemas in a more human readable format, embedded in web pages.

This plugin will allow adding *Docson widgets* into [Redmine](http://www.redmine.org/) wiki pages and issues.

## Requirements

- Requires Redmine v2.6+. Tested with Redmine v3.1.4, v3.2.3, v3.3.0 and v3.4.0.

- A *Docson* installation, in another web server or embedded in Redmine (see below)

## Installation

- install `redmine_docson` plugin:

  ```
  cd $REDMINE_HOME/plugins
  git clone https://github.com/mikitex70/redmine_docson.git
  ```

- restart Redmine to load the new plugin

- to install docson embedded into Redmine, download docson into `$REDMINE_HOME/public` directory. For example:

  ```
  cd $REDMINE_HOME/public
  git clone https://github.com/lbovet/docson.git
  ```
 
  Be warned: if docson is embedded with Redmine, JSON schemas must be served by Redmine to avoid cross-origin issues. In this case create also a folder for JSON schemas:
 
  ```
  mkdir $REDMINE_HOME/public/jsonSchemas
  ```

- go to the [plugin settings page](http://localhost:3000/settings/plugin/redmine_docson) and set the URL for Docson and the root path of the JSON schemas:

  * for the *Docson installation URL* use a full URL (for example `http://myserver:port/docson`) or an URL relative to Redmine (example: `/docson`), more simple if *Docson* installation is embedded.

  * for the *JSON schemas base path* use a path relative to the Docson URL (example: `/jsonSchemas`). Using a full URL is allowed, but schemas cannot be loaded from a server different from *Docson* server if they are not served following [CORS specifications](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing).

## Usage

- put your JSON schemas in the *JSON schemas base path* folder (or in sub-folders, for different projects).

- in Wiki pages use the `docson` macro to load the widget, specifying the path of the JSON schema relative to the public folder. For example, if the schema is in `jsonSchemas/myService/urn:jsonschema:my:package:myClass` use:

  ```
  {{docson(myService/urn:jsonschems:my:package:myClass)}}
  ```

### Using with Jackson

- Jackson schema generator generates schema references in the format `urn:jsonschema:className` where `className` is the full class name with dots replaced with colons. The schema files must be named with this notation or cannot be referenced by *Docson*.

  As workaround you can extend the `VisitorContext` class overriding the `javaTypeToUrn` method to produce the references in a different fashion.

- Microsoft Windows does not allow to create files containing the ':' character, so you must write a custom `VisitorContext` to construct the schemas URNs. For example:

  ```java
  import com.fasterxml.jackson.module.jsonSchema.factories.VisitorContext;

  public class VisitorContextSimplifiedUrn extends VisitorContext {
      @Override
      public String javaTypeToUrn(JavaType jt) {
          return "urn.jsonschema."+jt.toCanonical().replace('$', '.');
      }
  }
  ```

## Known issues

- Docson widgets are not rendered inside a PDF export: widgets are rendered on the HTML page using Javascript and cannot be rendered in PDF. As workaround you can print the web page as PDF document (easy with Linux, a bit more problematic in Windows).

## TODO

- Allow specify schemas from attachments.
- Allow specify schemas into ad macro body.
- Write tests.

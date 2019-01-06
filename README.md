# ProjectBuilder
Command line tool for creating a boilerplate project

### Installing
1. `git clone https://github.com/Beniamiiin/ProjectBuilder.git`
2. `cd ProjectBuilder`
3. `gem build project_builder.gemspec && sudo gem install project_builder-*.gem`

### Commands and options
Command: `gen` - generate project

Options: 
1. `--project-name`
2. `--organization-name`
3. `--bundle_id`
4. `--templates_repository` - default `https://github.com/Beniamiiin/ProjectBuilderCatalog.git`

### How to use
`project_builder gen --project-name "MyProject" --organization-name "bsarkisian.me" --bundle-id "bsarkisian.me.myproject"`

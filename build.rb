#!/usr/bin/env ruby
require "erb"
require "fileutils"
require "yaml"

include ERB::Util

SITE_URL = "https://kaelsantini.github.io"
ROUTES = { "en" => "/", "pt-BR" => "/pt/" }.freeze
CONTACTS = {
  "kael.santini@gmail.com" => "mailto:kael.santini@gmail.com",
  "GitHub" => "https://github.com/kaelsantini",
  "LinkedIn" => "https://www.linkedin.com/in/kael-santini-6849ab215/"
}.freeze
COPY_ICON = %(<svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><g class="icon-copy"><rect x="9" y="9" width="12" height="12"/><path d="M5 15H3V3h12v2"/></g><path class="icon-done" d="M4 12l6 6L20 6"/></svg>)

ROOT = __dir__
DIST = File.join(ROOT, "dist")

template = ERB.new(File.read(File.join(ROOT, "templates/index.html.erb")), trim_mode: "-")

def contact_item(label, href, t)
  link = %(<a href="#{h href}">#{h label}</a>)
  return %(<li>#{link}</li>) unless href.start_with?("mailto:")

  button = %(<button type="button" class="copy" data-copy="#{h label}" data-copied="#{h t["copied"]}" aria-label="#{h t["copy_email"]}" title="#{h t["copy_email"]}" hidden>#{COPY_ICON}</button>)
  %(<li>#{link}#{button}<span class="visually-hidden" role="status"></span></li>)
end

FileUtils.rm_rf(DIST)
FileUtils.mkdir_p(DIST)
FileUtils.cp_r(File.join(ROOT, "assets"), DIST)

ROUTES.each do |code, path|
  t = YAML.load_file(File.join(ROOT, "content/#{code}.yml"))
  url = "#{SITE_URL}#{path}"
  other_code, other_path = ROUTES.find { |other, _| other != code }
  contacts = %(<ul class="contacts">#{CONTACTS.map { |label, href| contact_item(label, href, t) }.join}</ul>)

  output = File.join(DIST, path, "index.html")
  FileUtils.mkdir_p(File.dirname(output))
  File.write(output, template.result(binding))
end

puts "Built #{ROUTES.size} pages in dist/"

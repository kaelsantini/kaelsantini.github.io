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

ROOT = __dir__
DIST = File.join(ROOT, "dist")

template = ERB.new(File.read(File.join(ROOT, "templates/index.html.erb")), trim_mode: "-")
contacts = %(<ul class="contacts">#{CONTACTS.map { |label, href| %(<li><a href="#{h href}">#{h label}</a></li>) }.join}</ul>)

FileUtils.rm_rf(DIST)
FileUtils.mkdir_p(DIST)
FileUtils.cp_r(File.join(ROOT, "assets"), DIST)

ROUTES.each do |code, path|
  t = YAML.load_file(File.join(ROOT, "content/#{code}.yml"))
  url = "#{SITE_URL}#{path}"
  other_code, other_path = ROUTES.find { |other, _| other != code }

  output = File.join(DIST, path, "index.html")
  FileUtils.mkdir_p(File.dirname(output))
  File.write(output, template.result(binding))
end

puts "Built #{ROUTES.size} pages in dist/"

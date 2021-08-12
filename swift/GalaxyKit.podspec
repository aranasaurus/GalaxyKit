Pod::Spec.new do |spec|
  spec.name = "GalaxyKit"
  spec.version = "0.0.1"
  spec.summary = "A galaxy generating toolkit."
  spec.homepage = "https://github.com/aranasaurus/GalaxyKit"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Ryan Arana" => 'ryan.arana@gmail.com' }
  spec.social_media_url = "http://twitter.com/aranasaurus"

  spec.platform = :ios, "11.0"
  spec.swift_version = "4.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/aranasaurus/GalaxyKit.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "src/**/*.{h,swift}"
end

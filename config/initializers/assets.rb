# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( fontawesome-webfont.eot )
Rails.application.config.assets.precompile += %w( fontawesome-webfont.woff )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.precompile += %w( autocomplete-rails.js )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
 Rails.application.config.assets.precompile += %w( pagination.js )
 Rails.application.config.assets.precompile += %w( monologue/foundation_icons/social_foundicons.eot )
 Rails.application.config.assets.precompile += %w( monologue/foundation_icons/social_foundicons.woff )
 Rails.application.config.assets.precompile += %w( monologue/foundation_icons/social_foundicons.ttf )
 Dir.glob("#{Rails.root}/app/assets/images/**/").each do |path|
  Rails.application.config.assets.paths << path
end


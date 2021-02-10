const { environment } = require('@rails/webpacker')

module.exports = environment

environment.config.merge({
    output: {
      library: ['Packs', '[name]'], // exports to "Packs.application" from application pack
      libraryTarget: 'var',
    }
  })
const path = require("path");

module.exports = {
    configureWebpack: {
        output: {
            filename: 'belvo-widget.js',
        },
        optimization: {
          splitChunks: false
        },
      },
    outputDir: path.resolve(__dirname, "../dist/"),
    devServer: {
        disableHostCheck: true
    },
    filenameHashing: false
}
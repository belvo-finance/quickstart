const path = require("path");

process.env.NODE_ENV = process.env.BELVO_ENV;

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
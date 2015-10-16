'use strict';

var path = require('path');

module.exports = {
  context: path.resolve(__dirname, 'src'),
  devtool: 'source-map',
  entry: './.webpack.js',
  module: {
    loaders: [
      {
        loader: 'purs-loader',
        query: {
          ffi: [
            'bower_components/purescript-*/src/**/*.js',
            'src/**/*.js'
          ],
          output: 'output',
          src: [
            'bower_components/purescript-*/src/**/*.purs',
            'src/**/*.purs'
          ]
        },
        test: /\.purs$/
      }
    ]
  },
  output: {
    filename: 'app.js',
    path: __dirname
  },
  resolve: {
    extensions: [
      '',
      '.js',
      '.purs'
    ],
    modulesDirectories: [
      'node_modules',
      'bower_components/purescript-prelude/src',
      path.resolve(__dirname, 'output')
    ]
  },
  resolveLoader: {
    root: path.resolve(__dirname, 'node_modules', 'pulp', 'node_modules')
  }
};

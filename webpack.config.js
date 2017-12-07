const webpack = require('webpack')
const path = require('path')

module.exports = {
	context: path.resolve(__dirname, './src/js'),
	entry: {
		index: './index.js'
	},
	output: {
		path: path.join(__dirname, 'dist/js/'),
		filename: '[name].js'
	},
	module: {
		loaders: [{
			test: /\.css/,
			loaders: [
				'style-loader',
				{
					loader: 'css-loader',
					options: { url: false }
				}
			]
		},{
			test: /\.tag$/,
			enforce: 'pre',
			exclude: /node_modules/,
			loader: 'tag-pug-loader'
		},{
			test: /\.js|\.tag$/,
			enforce: 'post',
			exclude: /node_modules/,
			use: {
				loader: 'babel-loader',
				query: {
					presets: ['es2015-riot']
				}
			}
		}]
	},
	resolve: {
		extensions: ['.js', '.tag']
	},
	plugins: [
		new webpack.ProvidePlugin({
			$: 'jquery',
			jQuery: 'jquery',
			'window.jQuery': 'jquery',
			riot: 'riot'
		})
	]
}

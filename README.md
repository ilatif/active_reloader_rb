# ActiveReloader

This is a Rails gem that reloads browser as soon as you do some changes in your Rails app. We as web developers are sometimes bounded in `Change -> Switch to Browser -> Refresh -> Change` cycle. This really hurts productivity. This gem will help you in breaking this cumbersome routine and your browser will be refreshed automatically whenever it detects any change in Rails code thus freeing you from that manually updating browser and hence resulting in increased productivity. 

## Installation

Add this line to your application's Gemfile:

    gem 'active_reloader'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_reloader

## Usage

After gem installation just enter following line into your project's `application.js`
	
	//= require active_reloader
	
By-default `ActiveReloader` looks for changes in `app` directory. You can easily add / modify directories according to your choice. To update directories list first create an `initializer` in your Rails app and use following code:

	ActiveReloader::Configuration.update do |config|
		config.paths << ["config", "db"]
	end

You can also use following way to provide single directory:

	config.paths << "config"
	
If you want to completely replace and provide new directories you can use:

	config.paths = "config"
	# or
	config.paths = ["config", "db"]
	
Always provide directories relative to your Rails app. For example if you want to look for changes in `config/initializers` directory you can use following code:

	config.paths << "config/initializers"

## How It Works

### Dedicated Server

`ActiveReloader` runs on separate server than that of your Rails app. As soon as you starts your Rails app a separate server will automatically be created for serving `ActiveReloader` requests. `ActiveReloader`'s server run on `Rails' port + 1`. This means if you have run your Rails app on port `3000` then `ActiveReloader` will automatically run on port `3001`. Similarly if you choose port `5555` for your Rails app, `ActiveReloader` will use port `5556`.

The reason of running `ActiveReloader` on a separate server is quite obvious. It don't want to interfere with your application code thus your Rails server don't need to serve requests related to `ActiveReloader`. The second reason is `Rack::Lock` middleware. This middleware is inserted by-default by Rails and because of this no other request can get processed until current running request is finished. Since `ActiveReloader` uses `Ajax Polling` to look for changes in your code, which means if `ActiveReloader`'s `Ajax` request is getting processed your Rails app's requests will not be entertained. So the obvious solution is to use a separate server for doing stuff related to `ActiveReloader`.

### Ajax Polling

You might be wondering why `Ajax Polling` when there are options available like `WebSockets` and `Server-Sent Events`. The answer to this question is simplicity. Doing `Ajax` requests seems quite natural way of doing things when it comes to get some updates from back-end server. Other solutions require some configuration while no configuration etc. needs to be made with `Ajax` and it works on every Ruby web-server available. Since `ActiveReloader`'s server is running locally its can serve requests at a blazing fast speed.

To increase performance of `ActiveReloader`'s server instead of doing `Ajax` requests after each 01 second I implemented `Ajax Polling` which when request is send will keep looking for changes in a loop for 25 seconds and will break as soon as any change is detected.

### Parent - Child Window Communication

`active_reloader.js` upon it's execution creates an `iframe` which points to `ActiveReloader`'s server. Upon any change found `ActiveReloader`'s JavaScript communicate with parent `window` by using `postMessage` which is considered to be the best option for communicating between parent and child windows.

## Beware

`ActiveReloader` is intended to be used only in `development` environment. It is not developed to be the next **hot code reloader / swapper**. Necessary checks have been placed to make sure `ActiveReloader` only works in `development` environment when Rails server is running.

## Special Thanks

Special thanks to following awesome developers for testing `ActiveReloader` gem.

- [Muhammad Irfan](https://github.com/mirfan899)
- [Kamal Ejaz](https://github.com/victorcreed)


## Contributing

1. Fork it ( https://github.com/ilatif/active_reloader/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

// This file contains code that will look for changes in Rails project and provide information to related object in parent iframe
window.addEventListener('message', function(event) {
	var active_reloader_config = event.data.active_reloader_config;
	__ActiveReloader.start({rails_root: active_reloader_config.rails_root, paths: active_reloader_config.paths});
});

window.parent.postMessage({provide_config: 1}, "*");

var __ActiveReloader = {
	last_reload_time: 0,
	start: function(options) {
		this._prepare_options(options);
		this._start();
	},
	_prepare_options: function(options) {
		this.options = options;
		if (!this.options.delay) {
			this.options.delay = 1000;
		}
		this.options.path = "/check_for_changes";
	},
	_start: function() {
		var self = this;
		setTimeout(function() {
			self._check_for_reloading();
		}, self.options.delay);
	},
	_check_for_reloading: function() {
		var self = this;
		$.get(self.options.path, self.options, function(response) {
			if (response.status == 1) {
				window.parent.postMessage({refresh: 1}, "*");
			}
			self._start();
		});
	}
}
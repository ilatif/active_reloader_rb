// This is the JavaScript file that will create an iframe that will be responsible for listening for changes in Rails project and for reloading main browser
//= require active_reloader_initializer
window.addEventListener('message', function(event) {
	if (event.origin == "http://localhost:3001") {
		if (event.data.provide_config) {
			$("#active_reloader_iframe")[0].contentWindow.postMessage({active_reloader_config: __ActiveReloaderInitializer.config()}, "*");
		} else if (event.data.refresh) {
			window.location.reload();
		}
	}
});
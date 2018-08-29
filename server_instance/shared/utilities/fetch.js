import { customPathURL } from "shared/utilities/urls";

// Async function for handling front-end get, post and patch calls
export default {
	async execute(path, options) {
		const route = customPathURL(path);
		// Set default headers
		options.headers = Object.assign(
			{
				Accept: "application/json",
				"Content-Type": "application/json",
				Pragma: "no-cache"
			},
			options.headers || {}
		);

		// Add security token to header
		if (this.token != null) {
			options.headers = Object.assign(options.headers, {
				Authorization: `jwt ${this.token}`
			});
		}

		// Perform fetch on the endpoint
		const response = await fetch(route, options);

		// Handle server side redirects
		if (response.redirected) {
			return window.location.replace(response.url);
		}

		// Valid response if status 200 ~ 299
		let json = response.json();
		if (response.status >= 200 && response.status < 300) {
			return json;
		}

		// Throw error if any other response from server
		return json.then(error => {
			throw error;
		});
	},

	setSecurityToken(token) {
		this.token = token;
	},

	getSecurityToken() {
		return this.token;
	},

	clearSecurityToken() {
		this.token = null;
	},

	perform(path, options = {}) {
		return this.execute(path, options);
	}
};

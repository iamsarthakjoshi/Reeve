// Account Registration
export function clientRegistration(client) {
	return fetch("/internal/register/", {
		method: "POST",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json",
			Pragma: "no-cache"
		},
		body: JSON.stringify({
			workspaceURL: client.workspaceURL,
			firstName: client.firstName,
			lastName: client.lastName,
			emailAddress: client.emailAddress,
			password: client.password
		})
	});
}

// User Login
export function userLogin(user) {
	return fetch("/internal/login/", {
		method: "POST",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json",
			Pragma: "no-cache"
		},
		body: JSON.stringify({
			workspaceURL: user.organizationName,
			emailAddress: user.emailAddress,
			password: user.password,
			keepSignedIn: user.keepSignedIn
		})
	});
}

// Workspace URL Validation
export function workspaceURLValidation(workspaceURL) {
	return fetch("/internal/validate_workspace_url/", {
		method: "GET",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json",
			Pragma: "no-cache"
		},
		body: JSON.stringify({
			workspaceURL: workspaceURL
		})
	});
}

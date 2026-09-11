function insert(url, selector) {
	const here = document.currentScript;
	const content = document.createElement("div");
	here.parentNode.insertBefore(content, here);

	fetch(url).then(function (response) {
		if (response.ok) {
			return response.text();
		}
		throw response;
	}).then(html => {
	    const parser = new DOMParser();
		const doc = parser.parseFromString(html, "text/html");

		var parentUrl = url.substring(0, url.lastIndexOf("/"));
		if (parentUrl.startsWith("//")) {
			parentUrl = "https:" + parentUrl;
		}

		// rewrite href urls
		doc.querySelectorAll('[href]').forEach(el => {
            const rawHref = el.getAttribute('href');
            // Safely resolve only if it exists and isn't an anchor or absolute already
            if (rawHref && !rawHref.startsWith('#') && !rawHref.includes('://')) {
                el.setAttribute('href', new URL(rawHref, parentUrl).href);
            }
        });

		// rewrite src urls
        doc.querySelectorAll('[src]').forEach(el => {
            const rawSrc = el.getAttribute('src');
            if (rawSrc && !rawSrc.includes('://')) {
                el.setAttribute('src', new URL(rawSrc, parentUrl).href);
            }
        });

		if (selector) {
			// content.innerHTML = doc.querySelector(selector).innerHTML;
			let combinedHTML = '';
			document.querySelectorAll(selector).forEach(el => {
			  combinedHTML += el.innerHTML;
			});
			content.innerHTML = combinedHTML;
		} else {
			content.innerHTML = doc.documentElement.innerHTML;
		}
	  })
	  .catch(error => {
	     content.innerHTML = 'Failed to fetch page: ' + error;
	     console.error('Failed to fetch page: ', error);
	  })
}

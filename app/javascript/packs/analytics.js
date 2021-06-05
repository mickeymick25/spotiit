window.dataLayer = window.dataLayer || [];
function gtag() { dataLayer.push(arguments); }

gtag('js', new Date());

const trackGoogleAnalytics = (event) => {
  gtag('config', 'G-MNH7GGVFB6');
}

document.addEventListener('turbolinks:load', trackGoogleAnalytics)

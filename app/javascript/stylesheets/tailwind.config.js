module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/javascript/**/*.vue'
    // Add any other JS files here (i.e. .jsx, .ts, etc...)
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        primary: 'var(--color-primary)',
        secondary: 'var(--color-secondary)'
      },
      gradientColorStops:{
        primary: 'var(--color-primary)',
        secondary: 'var(--color-secondary)'
      },
      textColor: {
       primary: 'var(--color-primary)',
       secondary: 'var(--color-secondary)'
     }
    },
  },
  variants: {},
  plugins: [],
}

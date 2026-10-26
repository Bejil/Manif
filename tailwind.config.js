/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './app/components/**/*.{vue,js,ts}',
    './app/layouts/**/*.vue',
    './app/pages/**/*.vue',
    './app/app.vue',
    './app/error.vue',
  ],
  theme: {
    extend: {
      colors: {
        ink: {
          DEFAULT: '#111111',
          soft: '#252525',
          muted: '#454545',
          faint: '#636363',
        },
        paper: {
          DEFAULT: '#FFFCF4',
          muted: '#F4F1EA',
          raised: '#FFFFFF',
        },
        violet: {
          DEFAULT: '#9C6EE8',
          deep: '#6735B6',
          wash: '#F0E8FC',
          ink: '#4D257D',
        },
        red: {
          DEFAULT: '#D1271C',
          wash: '#FDEDEB',
          ink: '#97251B',
        },
        gray: {
          900: '#252525',
          700: '#454545',
          500: '#636363',
          200: '#DDDAD3',
          100: '#F4F1EA',
        },
        // Compat composants legacy
        brand: {
          deep: '#111111',
          accent: '#6735B6',
          'accent-hover': '#562C98',
          soft: '#F0E8FC',
        },
        surface: {
          DEFAULT: '#FFFCF4',
          raised: '#FFFFFF',
          muted: '#F4F1EA',
        },
        night: {
          DEFAULT: '#111111',
          soft: '#252525',
        },
        coral: {
          DEFAULT: '#D1271C',
          hover: '#B52118',
          soft: '#FDEDEB',
          ink: '#97251B',
        },
        mist: {
          DEFAULT: '#9C6EE8',
          soft: '#F0E8FC',
          ink: '#4D257D',
        },
        amber: {
          DEFAULT: '#805200',
          soft: '#F4F1EA',
          ink: '#805200',
        },
        status: {
          upcoming: '#4D257D',
          ongoing: '#97251B',
          past: '#454545',
          cancelled: '#AD291F',
          postponed: '#805200',
        },
      },
      fontFamily: {
        display: ['Anton', 'Impact', 'Arial Narrow', 'sans-serif'],
        sans: ['Inter', 'Arial', 'Helvetica', 'sans-serif'],
      },
      boxShadow: {
        soft: '0 8px 30px rgba(17,17,17,.08)',
        lift: '0 12px 36px rgba(17,17,17,.12)',
      },
      borderRadius: {
        manif: '8px',
        'manif-lg': '12px',
      },
      maxWidth: {
        content: '75rem',
      },
    },
  },
  plugins: [],
}

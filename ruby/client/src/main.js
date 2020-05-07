import Vue from 'vue'
import App from './App.vue'
import '@belvo-finance/belvo-vue-components/dist/vue-components/belvo-vue-components.css'
import BelvoComponentsPlugin from '@belvo-finance/belvo-vue-components'

Vue.use(BelvoComponentsPlugin)
console.log('window', window)
new Vue({
  render: h => h(App),
}).$mount('#app')


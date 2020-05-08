import Vue from 'vue'
import App from './App.vue'
import '@belvo/belvo-vue-components/dist/vue-components/belvo-vue-components.css'
import BelvoComponentsPlugin from '@belvo/belvo-vue-components'

Vue.use(BelvoComponentsPlugin)
console.log('window', window)
new Vue({
  render: h => h(App),
}).$mount('#app')


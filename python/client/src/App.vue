<template>
  <div id="app">
      <div class="layout">
        <Intro/>
        <Requests/>
      </div>
  </div>
</template>

<script>
import Intro from './components/Intro.vue'
import Requests from './components/Requests.vue'

export default {
  name: 'App',
  components: {
    Intro,
    Requests
  }
}
</script>

<style>
body {
  background-color: #f0f2f4;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  margin-top: 60px;
}

.layout {
  width: 960px;
  margin: 0 auto;
  padding-top: 64px;
}
</style>

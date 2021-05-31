<template>
  <div id="app">
      <div class="layout">
        <div class="row pb-xl">
          <div class="col">
            <div class="text-medium-36">
              Belvo quickstart
            </div>
          </div>
        </div>
        <Intro v-if="!linkId" v-on:setLinkId="handleSetLinkId" />
        <Requests v-if="linkId" :linkId="this.linkId" />
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
  },
  data() {
    return {
      linkId: null,
    }
  },
  mounted() {
    let belvoScript = document.createElement('script')
    belvoScript.setAttribute('src', 'https://cdn.belvo.io/belvo-widget-1-stable.js')
    document.head.appendChild(belvoScript)
  },
  methods: {
    handleSetLinkId(linkId) {
      this.linkId = linkId;
    }
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

<template>
  <div>
    <div class="row pb-xl">
      <div class="col">
        <div class="text-regular-20 pb-m">
          An example application that outlines an end-to-end integration with Belvo
        </div>
        <div class="divider" />
        <div class="text-regular-16 pt-m">
          Click the button below to open a list of Institutions. After you select one, you’ll be guided through an authentication process. Upon completion, a link will be created and you will be able to retrieve accounts, transactions, balances and owners.
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-3" :v-if="this.success === false">
        <b-button :fluid="true" text="Connect with Belvo" @clicked="openBelvoWidget()" />
      </div>
    </div>
  </div>
</template>

<script>
  import axios from "axios";
  
  export default {
    name: 'Intro',
    data() {
      return {
        access_token: null,
        success: false
      }
    },
    methods: {
      openBelvoWidget() {
        axios.get('http://127.0.0.1:5000/get_token')
          .then((response) => {
            const access_token = response.data.access;
            window.belvoSDK.createWidget(access_token, {
              locale: 'es', // 'en' for English
              country_codes: ['MX', 'CO', 'BR'],
              callback: (link) => this.successCallbackFunction(link),
              onExit: (data) => this.onExitCallbackFunction(data),
              onEvent: (data) => console.log('data', data)
            }).build();
          })
      },
      successCallbackFunction(link_id) {
        this.$emit('setLinkId', link_id)
        localStorage.setItem('link', link_id)
      },
      onExitCallbackFunction(data) {
        console.log('data', data)
      }
    }
  }
</script>
<style>
  .divider {
    border-bottom: .0625rem solid #d3d9de;
  }
</style>

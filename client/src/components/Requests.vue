<template>
  <div>
    <div class="row pb-xl">
      <div class="col">
        <div class="text-regular-20 pb-m">
          Success! You just created a link in Belvo.
        </div>
        <div class="divider" />
      </div>
    </div>
    <div class="row mb-xl">
      <div class="col-6">
        <p class="title">LINK  ID</p>
        <p class="data">{{this.linkId}}</p>
      </div>
    </div>
    <card class="widget-list">
      <div slot="content">
        <div class="widget-list__header px-l py-l">
          <div class="row flex-middle">
            <div class="col">
              <div class="text-medium-16">
                ENDPOINTS
              </div>
            </div>
          </div>
        </div>
        <div class="widget-list__content px-l">
          <div
            class="list-item"
          >
            <div class="row py-m flex-between">
              <div
                class="two-list-item-action__left-item col request-title"
              >
                <div class="text-regular-14 request-type post mr-l">
                  POST
                </div>
                <div class="request-content">
                  <div class="row">
                    <div class="text-medium-16 mr-m">
                      Accounts
                    </div>
                    <div class="text-regular-14">
                      /api/accounts/
                    </div>
                  </div>
                  <div class="row">
                    <div class="text-regular-14">
                      Retrieve accounts in the institution from an existing link.
                    </div>
                  </div>
                </div>
              </div>
              <div
                class="list-item-action col"
              >
                <b-button type="primary" :fluid="false" text="Send request" @clicked="retrieveAccounts()" />
              </div>
            </div>
            <div class="request-response" v-if="this.accounts">
              <div
                class="row response-header pb-s"
              >
                <div class="text-medium-14 col">
                  Name
                </div>
                <div class="text-medium-14 col">
                  Account Number
                </div>
                <div class="text-medium-14 col">
                  Balance
                </div>
              </div>
              <div :key="item.id" v-for="item in this.accounts" class="row mb-xl pt-m pb-m">
                <div class="text-regular-16 col">
                  {{item.name}}
                </div>
                <div class="text-regular-16 col">
                  {{item.number}}
                </div>
                <div class="text-regular-16 col">
                  ${{item.balance.current}}
                </div>
              </div>
            </div>
          </div>
          <div
            class="list-item"
          >
            <div class="row py-m flex-between">
              <div
                class="two-list-item-action__left-item col request-title"
              >
                <div class="text-regular-14 request-type post mr-l">
                  POST
                </div>
                <div class="request-content">
                  <div class="row">
                    <div class="text-medium-16 mr-m">
                      Transactions
                    </div>
                    <div class="text-regular-14">
                      /api/transactions/
                    </div>
                  </div>
                  <div class="row">
                    <div class="text-regular-14">
                      Retrieve last 30 days transactions from all accounts in a specific link.
                    </div>
                  </div>
                </div>
              </div>
              <div
                class="list-item-action col"
              >
                <b-button type="primary" :fluid="false" text="Send request" @clicked="retrieveTransactions()" />
              </div>
            </div>
            <div class="request-response" v-if="this.transactions">
              <div
                class="row response-header pb-s"
              >
                <div class="text-medium-14 col">
                  Name
                </div>
                <div class="text-medium-14 col">
                  Amount
                </div>
                <div class="text-medium-14 col">
                  Date
                </div>
              </div>
              <div :key="item.id" v-for="item in this.transactions" class="row mb-xl pt-m pb-m">
                <div class="text-regular-16 col">
                  {{item.description}}
                </div>
                <div class="text-regular-16 col">
                  {{item.amount}}
                </div>
                <div class="text-regular-16 col">
                  {{ formatDate(item.value_date) }}
                </div>
              </div>
            </div>
          </div>
          <div class="list-item">
            <div class="row py-m flex-between">
              <div
                class="two-list-item-action__left-item col request-title"
              >
                <div class="text-regular-14 request-type post mr-l">
                  POST
                </div>
                <div class="request-content">
                  <div class="row">
                    <div class="text-medium-16 mr-m">
                      Balance
                    </div>
                    <div class="text-regular-14">
                      /api/balances/
                    </div>
                  </div>
                  <div class="row">
                    <div class="text-regular-14">
                      Retrieve last 30 days balances of all accounts in a specific link.
                    </div>
                  </div>
                </div>
              </div>
              <div
                class="list-item-action col"
              >
                <b-button type="primary" :fluid="false" text="Send request" @clicked="retrieveBalances()" />
              </div>
            </div>
            <div class="request-response" v-if="this.balances">
              <div
                class="row response-header pb-s"
              >
                <div class="text-medium-14 col">
                  Name
                </div>
                <div class="text-medium-14 col">
                  Balance
                </div>
                <div class="text-medium-14 col">
                  Date
                </div>
              </div>
              <div :key="item.id" v-for="item in this.balances" class="row mb-xl pt-m pb-m">
                <div class="text-regular-16 col">
                  {{item.account.name}}
                </div>
                <div class="text-regular-16 col">
                  {{item.current_balance}}
                </div>
                <div class="text-regular-16 col">
                  {{ formatDate(item.value_date) }}
                </div>
              </div>
            </div>
          </div>
          <div class="list-item">
            <div class="row py-m flex-between">
              <div
                class="two-list-item-action__left-item col request-title"
              >
                <div class="text-regular-14 request-type post mr-l">
                  POST
                </div>
                <div class="request-content">
                  <div class="row">
                    <div class="text-medium-16 mr-m">
                      Owners
                    </div>
                    <div class="text-regular-14">
                      /api/owners/
                    </div>
                  </div>
                  <div class="row">
                    <div class="text-regular-14">
                      Retrieve information on the owner of a specific link.
                    </div>
                  </div>
                </div>
              </div>
              <div
                class="list-item-action col"
              >
                <b-button type="primary" :fluid="false" text="Send request" @clicked="retrieveOwners()" />
              </div>
            </div>
            <div class="request-response" v-if="this.owners">
              <div
                class="row response-header pb-s"
              >
                <div class="text-medium-14 col">
                  Name
                </div>
                <div class="text-medium-14 col">
                  Email
                </div>
                <div class="text-medium-14 col">
                  Phone Number
                </div>
              </div>
              <div :key="item.id" v-for="item in this.owners" class="row mb-xl pt-m pb-m">
                <div class="text-regular-16 col">
                  {{item.display_name}}
                </div>
                <div class="text-regular-16 col">
                  {{item.email}}
                </div>
                <div class="text-regular-16 col">
                  {{item.phone_number}}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </card>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  name: 'Requests',
  props: {
    linkId: String
  },
  data() {
    return {
      accounts: null,
      transactions: null,
      balances: null,
      owners: null
    }
  },
  methods: {
    retrieveAccounts() {
      axios.post('http://127.0.0.1:5000/accounts', {link_id: this.linkId})
          .then((response) => {
            this.accounts = response.data;
          })
    },
    retrieveTransactions() {
      axios.post('http://127.0.0.1:5000/transactions', {link_id: this.linkId})
          .then((response) => {
            this.transactions = response.data;
          })
    },
    retrieveBalances() {
      axios.post('http://127.0.0.1:5000/balances', {link_id: this.linkId})
          .then((response) => {
            this.balances = response.data;
          })
    },
    retrieveOwners() {
      axios.post('http://127.0.0.1:5000/owners', {link_id: this.linkId})
          .then((response) => {
            this.owners = response.data;
          })
    },
    formatDate(date) {
      return moment(date).format('DD-MM-YYYY')
    }
  }
}
</script>
<style lang="scss" scoped>
  .title {
    position: relative;
    z-index: 2;
    width: 90px;
    text-transform: uppercase;
    font-size: .90rem;
    font-weight: 600;
    line-height: 24px;
    font-family: Noto Sans TC;
    margin: 0;
  }
  .data {
    margin: 0;
    font-family: Noto Sans TC;
  }
  .widget-list {
    &__header {
      border-bottom: 1px solid #f0f2f4;

      &-table {
        color: grey;
        &-event {
          padding-right: 95px;
        }

        &-callback {
          padding-right: 361px;
        }

        &-status {

        }
      }
    }
  }
  .list-item {
    border-bottom: .0625rem solid #f0f2f4;
    .list-item-action {
      display:  flex;
      justify-content: flex-end;
    }
  }
  .request-type {
    padding: 5px 15px;
    background: #ebebeb;
    color: #ffffff;

    &.post {
      background: rgb(36, 143, 178);
    }
  }
  .request-content {
    min-width: 550px;
  }
  .request-title {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    width: 200px;
  }
  .response-header {
    color: #c4cdd4;
  }
</style>

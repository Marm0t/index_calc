<template>
    <div class="container" id="app">

    <h1>Калькулятор индекса Мосбиржи</h1>
    <Calculator v-on:inputValueChanged="valueToPassToIndexList = $event"> </Calculator>
    <IndexList :sumToBuy = "valueToPassToIndexList"/>

    </div>


</template>

<script>
import Calculator from './components/Calculator.vue'
import IndexList from './components/IndexList.vue'

export default {
  name: 'App',
  components: {
    "Calculator": Calculator,
    "IndexList" : IndexList
  },
  data: function (){
    return {
      valueToPassToIndexList: 0
    }
  }


}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50; 
  margin-top: 60px;
}
</style>

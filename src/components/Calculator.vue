<template>
    <div class='card'>
        <!-- <h3>{{ title }} </h3> -->
        <div class="form-control">
          <h3>Вы хотите следовать индексу Мосбиржи, но не хотите покупать ETF?</h3>
          <p>Этот калькулятор рассчитает сколько и каких акций нужно купить, чтобы максимально точно следовать индексу.<br>
          Сколько Вы хотите вложить?</p>
           <input type="number" 
               v-bind:placeholder=" inputValuePlaceholder "
               v-model = "inputValue">
          <p v-if="inputValue && inputValue<100000">Внимание: чем выше сумма, тем точнее будет следование Индексу. Хорошо бы иметь миллион и более, но не у всех он есть :( </p>
        </div>
        
    </div>
</template>

<script>
export default {
      name: 'Calculator',
      data() {
        return {
            title: 'Калькулятор индекса Мосбиржи',
            inputValuePlaceholder: 'введите сумму в рублях',
            inputValue: ''
        }
      },// data()

      methods: {


      },// methods

      watch:{

        inputValue(value){
            this.$emit('inputValueChanged', value)
        }

      }// watch


    
}
</script>










<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
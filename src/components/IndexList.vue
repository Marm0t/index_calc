<template>
<div class='card'>
    <!-- <h3>{{title}}</h3> -->
    <div class="form-control">
    <ul class="responsive-table" v-if="indexComponents.length !== 0">
      <li class="table-header list-item">
            <div class="col col-1" v-on:click="sortConponentsByTicker">Тикер</div>
            <div class="col col-2">Название</div>
            <div class="col col-3" v-on:click="sortConponentsByWeight">Вес</div>
            <div class="col col-4">Цена</div>
      </li>

      <li class="table-row list-item" 
          v-for="(item,idx) in indexComponents" :key="idx"
          v-on:click="itemClicked(idx)" >
        <div class="col col-1" data-label="Ticker">{{item.ticker}}</div>
        <div class="col col-2" data-label="Name">{{item.company_name}}</div>
        <div class="col col-3" data-label="Weight">{{item.weight}}</div>
        <div class="col col-4">{{item.last_price}} </div>
      </li>
    </ul>
    <div v-else>
      Список пуст
    </div>
    </div>
</div>
</template>

<script>

var url_imoex = "https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities.json?marketdata.columns=LAST&securities.columns=SECID,SHORTNAME,SECNAME&iss.meta=off&iss.only=marketdata,securities&securities=";
var imoex = [
{ticker:"AFKS" , weight:"0.5"},
{ticker:"AFLT" , weight:"0.35"},
{ticker:"ALRS" , weight:"1.69"},
{ticker:"CBOM" , weight:"0.2"},
{ticker:"CHMF" , weight:"1.63"},
{ticker:"DSKY" , weight:"0.41"},
{ticker:"FEES" , weight:"0.25"},
{ticker:"FIVE" , weight:"1.4"},
{ticker:"FIXP" , weight:"0.57"},
{ticker:"GAZP" , weight:"15.45"},
{ticker:"GLTR" , weight:"0.27"},
{ticker:"GMKN" , weight:"7.17"},
{ticker:"HHRU" , weight:"0.42"},
{ticker:"HYDR" , weight:"0.45"},
{ticker:"IRAO" , weight:"0.8"},
{ticker:"LKOH" , weight:"11.28"},
{ticker:"LSRG" , weight:"0.17"},
{ticker:"MAGN" , weight:"0.7"},
{ticker:"MAIL" , weight:"0.89"},
{ticker:"MGNT" , weight:"1.74"},
{ticker:"MOEX" , weight:"1.25"},
{ticker:"MTSS" , weight:"1.41"},
{ticker:"NLMK" , weight:"1.56"},
{ticker:"NVTK" , weight:"5.13"},
{ticker:"OZON" , weight:"0.79"},
{ticker:"PHOR" , weight:"0.81"},
{ticker:"PIKK" , weight:"0.65"},
{ticker:"PLZL" , weight:"2.13"},
{ticker:"POGR" , weight:"0.31"},
{ticker:"POLY" , weight:"2.9"},
{ticker:"ROSN" , weight:"3.37"},
{ticker:"RSTI" , weight:"0.15"},
{ticker:"RTKM" , weight:"0.47"},
{ticker:"RUAL" , weight:"0.65"},
{ticker:"SBER" , weight:"13"},
{ticker:"SBERP", weight:"1.17"},
{ticker:"SNGS" , weight:"1.55"},
{ticker:"SNGSP", weight:"1.15"},
{ticker:"TATN" , weight:"1.79"},
{ticker:"TATNP", weight:"0.35"},
{ticker:"TCSG" , weight:"3.89"},
{ticker:"TRNFP", weight:"0.48"},
{ticker:"VTBR" , weight:"1.13"},
{ticker:"YNDX" , weight:"7.56"}
]

function compareByTicker( a, b ) {
  if ( a.ticker < b.ticker ){ return -1; }
  if ( a.ticker > b.ticker ){ return 1;  }
  return 0;
}
function compareByWeight( a, b ) {
  if ( parseFloat(a.weight) < parseFloat(b.weight) ){ return 1; }
  if ( parseFloat(a.weight) > parseFloat(b.weight) ){ return -1;  }
  return 0;
}

import axios from 'axios'

export default {
      name: 'IndexList',
      data() {
        return {
          title: '',
          indexComponents : imoex
        }
      },

methods: {
      itemClicked(idx){
        console.log("Someone clicked on ", this.indexComponents[idx].ticker);
      },

      sortConponentsByTicker(){this.indexComponents.sort(compareByTicker)},
      sortConponentsByWeight(){this.indexComponents.sort(compareByWeight)},

      updateRates(){
        //console.log("Updating rates for " , this.indexComponents[idx]);
        var allComponentsStr = "";
        this.indexComponents.forEach(element => {
          allComponentsStr = allComponentsStr + "," + element.ticker;
        });
        console.log("Updating components by calling " + url_imoex+allComponentsStr);
        axios
          .get(url_imoex+allComponentsStr)
          .then(response => 
                  {
                      //console.log("Response from MICEX: ", response),
                      //console.log('Data on which we do FIND: ', response.data.securities.data[0]),
                      // Update each element in indexComponents
                      this.indexComponents.forEach(element => {
                        response.data.securities.data.find(function(item, index){
                          if (item[0] ==  element.ticker){
                            // Here we found an index in response arrays and ready to update _element_ which is in this.indexComponents
                            //console.log("Found it! ", index, element);
                            element["last_price"] = response.data.marketdata.data[index][0];
                            element["company_name"] =  response.data.securities.data[index][1];
                            return true;
                          }
                        })// end of FIND

                      })// end of for_each on indexComponents

                  }) // end of response handling
          .catch(error => console.log(error))
      }


},// methods



computed: {
}, // computed
  
watch: {
  indexComponents(value){
    console.log("indexComponents changed to: ", value)
  }
}, // watch

  mounted() {
    this.updateRates()
    
  }

}
</script>







<style scoped>

  .table-header {
    background-color: #95a5a6;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.03em;
    font-weight: bold
  }

   .table-row {
    box-shadow: 0px 0px 9px 0px rgba(0, 0, 0, 0.1);
  }

    .col-1 {
    flex-basis: 10%;
  }
  .col-2 {
    flex-basis: 40%;
  }
  .col-3 {
    flex-basis: 25%;
  }
  .col-4 {
    flex-basis: 25%;
  }


  @media all and (max-width: 767px) {
    .table-header {
      display: none;
    }
    li {
      display: block;
    }
    .col {
      flex-basis: 100%;
    }
    .col {
      display: flex;
      padding: 10px 0;
      color: #6c7a89;
      padding-right: 10px;
      content: attr(data-label);
      flex-basis: 50%;
      text-align: right;
    }
  }
</style>

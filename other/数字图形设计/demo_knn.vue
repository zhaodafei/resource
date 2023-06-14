<template>
  <div>
    <!--
        KNN算法流程总结:
        根据K个邻居判定你的类别
        1.计算当前样本与所有样本距离
        2.距离从小到大排序
        3.取前K个邻居
        4.K个邻居投票，统计投票结果
        5.根据投票结果值出现频率高类别作为最终类别
    -->
    <div>
      <input type="color" @change="changeColor" ref="clrDom" id="clrDom" value="#80ff00" />
      <el-input style="width: 60px;" type="number" v-model="KKKKK" id="KKKKK" placeholder="3" />
      <span id="point" :style="{color:point.color}">{{point.position}}</span>
    </div>
    <canvas @click="clickCanv" @mousemove="onMouseMove" @mouseout="onMouseOut" ref="canv" id="canv" style="border: 1px #ccc solid;"></canvas>

  </div>
</template>
<script setup>
import {ref, reactive, onMounted, getCurrentInstance, nextTick} from "vue";

const {proxy} = getCurrentInstance();

/**
 *
 * @param current {Number}
 * @param points {Array}
 * @param labelX
 * @param labelY
 * @param k  {Number}
 * @param c  {Function}
 * @returns {{classify: *[], dists: *[]}}
 */
const getKnn = (current, points, labelX, labelY, k, c) => {
  var dists = [];//存放最接近的
  var classify = [];//分类标识
  points.map(function (item) {
    if (classify.indexOf(item[labelY]) < 0) classify.push(item[labelY]);
    var result = {};
    result.p = item;
    result.d = c(current, item[labelX]) ;
    dists.push(result);
  });
  dists.sort(function (a, b) {//排序
    return a.d - b.d;
  });
  return { dists: dists.slice(0, k), classify: classify };
}

/**
 *
 * @param current {Object} 输入值
 * @param points {Object} 训练样本集
 * @param labelX {Object}  用于分类的输入值
 * @param labelY {Object}  用于分类的输出值
 * @param k  {Number}  用于选择最近邻的数目
 * @param c  {Function}  自定义比较函数
 * @returns {{result, dists: *[]}}
 */
const classify0 = (current, points, labelX, labelY, k, c) => {
  var result = [];
  var knn = getKnn(current, points, labelX, labelY, k, c);
  var dists = knn.dists;
  for (var i of knn.classify) {
    result.push({
      label: i,
      value: 0
    });
  }
  dists.map(function (item) {
    for (var i of result) {
      if (i.label === item.p[labelY]) {
        i.value++;
        break;
      }
    }
  });
  result.sort(function (a, b) {
    return b.value - a.value;
  });
  return { result: result[0].label, dists: dists };
}

const dataSet = ref([]);
const drawMousePoint = ref(false);
const canv = ref();
const clrDom = ref();
const KKKKK = ref(3);

// 辅助
const canvas = ref();
const cxt = ref();
const color = ref("#ff6b81");
const point = reactive({
  position: [0,0],
  color:'#ff6b81'
});

const getEvPoint = (e) => {
  return { x: e.layerX, y: e.layerY };
}

const onMouseOut = (e) => {
  if (!drawMousePoint.value) { return; }
  drawMousePoint.value = false;
}

const onMouseMove = (e) => {
  drawMousePoint.value = true;
  clear();
  draw(e);
}

const clickCanv = (e) => {
  var p = getEvPoint(e);
  dataSet.value.push({
    point: p,
    color: color.value
  });
}

const changeColor = (e) => {
  color.value = e.srcElement.value; // 或者 e.target.value
}
const clear = () => {
  cxt.value.clearRect(0, 0, canvas.value.width, canvas.value.height);
}
const draw = (e) => {
  var p = getEvPoint(e);
  var r = null;
  if (dataSet.value.length) {
    r = classify0(p, dataSet.value, 'point', 'color', parseInt(KKKKK.value) || 3,function(p1, p2){
      //根据欧几里得距离公式或勾股定理计算距离
      return Math.sqrt(Math.pow(p2.x - p1.x, 2) + Math.pow(p2.y - p1.y, 2));
    })
  }
  if (e) {
    // 鼠标位置显示圆点
    cxt.value.beginPath()
    cxt.value.arc(p.x, p.y, 8, 0, 2 * Math.PI, false)
    cxt.value.fillStyle = r && r.result ? r.result : '#efefef';
    cxt.value.stroke();
    cxt.value.fill();
    point.position = [p.x, p.y];
    point.color = cxt.value.fillStyle
  }

  // 空白区域绘制坐标点
  for (const i of dataSet.value) {
    cxt.value.beginPath();
    cxt.value.lineWidth = 1;
    cxt.value.arc(i.point.x, i.point.y, 4, 0, 2 * Math.PI, false);
    cxt.value.fillStyle = i.color;
    cxt.value.stroke();
    cxt.value.fill();
  }

  if (r) {
    // 鼠标位置与附近点显示连线
    for (const i of r.dists) {
      cxt.value.beginPath();
      cxt.value.lineWidth = 1;
      cxt.value.moveTo(p.x, p.y);
      cxt.value.lineTo(i.p.point.x, i.p.point.y);
      cxt.value.stroke();
      cxt.value.fill();
    }
  }
}

nextTick(()=>{
  canvas.value = proxy.$refs.canv;
  const clrDom = proxy.$refs.clrDom;
  // const KKKKK = proxy.$refs.KKKKK;
  cxt.value =  proxy.$refs.canv.getContext("2d")


  proxy.$refs.canv.width = 600;
  proxy.$refs.canv.height = 300;


})

</script>

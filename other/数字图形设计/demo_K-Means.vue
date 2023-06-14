<template>
  <!--
    K-Means算法流程总结:
    a) 从输入的数据点集合中随机选择一个点作为第一个聚类中心μ1
    b) 对于数据集中的每一个点xi，计算它与已选择的聚类中心中最近聚类中心的距离
    c) 选择一个新的数据点作为新的聚类中心，选择的原则是：D(x)较大的点，被选取作为聚类中心的概率较大
    d) 重复b和c直到选择出k个聚类质心
    e) 利用这k个质心来作为初始化质心去运行标准的K-Means算法
  -->
  <div class="fei-root aaaaaaaaaaa">
    <div style="position: absolute; top: 0; left: 38%;">
      <label style="width: 60px">
        请输入K值:<el-input type="number" v-model="k" style="width: 60px;" />
      </label>
      <el-button type="primary" @click="handleStartCalculate">开始计算</el-button>
      <el-button type="primary" @click="handleMoveKPoints">移动K点</el-button>
      <el-button type="primary" @click="handleReset">重置</el-button>
    </div>
    <div class="k-body">
      <!-- 质心点 -->
      <div
          v-for="k of kPoints"
          :key="k.id"
          :style="{ top: `${k.y}px`, left: `${k.x}px`, background: k.color }"
          class="k-point"
      />
      <!-- K个簇 -->
      <div
          v-for="point of dataSource"
          :key="point.id"
          :style="{ top: `${point.y}px`, left: `${point.x}px`, background: point.color }"
          class="point"
      />
    </div>

  </div>
</template>

<script setup>
import {ref, reactive, onMounted, getCurrentInstance, nextTick} from "vue";
const {proxy} = getCurrentInstance();

const COLORS = ['#297aff', '#ff9800', '#30af28', '#ffcc0d', '#00cccc', '#66ccff', '#01a5ed', '#009966', '#A0D911',]

const guid_1 = () => {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
    let r = (Math.random() * 16) | 0
    let v = c === 'x' ? r : (r & 0x3) | 0x8
    return v.toString(16)
  })
}
/**
 * 随机数范围
 */
function random(lower, upper) {
  if ( lower % 1 || upper % 1) {
    let rand = Math.random();
    return Math.min(lower + (rand * (upper - lower + freeParseFloat('1e-' + ((rand + '').length - 1)))), upper);
  }

  return lower + Math.floor( Math.random() * (upper - lower + 1));
}
const showSize = reactive({width: 500, height: 500}) // 显示范围大小(对应k-body宽高)
const dataSource_pointNum = ref(600); // K个簇所有点数量
// const dataSource_pointNum = ref(10); // K个簇所有点数量(调试值)

const DEFAULT_COLOR = '#000000'
const dataSource = ref([]) // 样本
const kPoints = ref([]) // 质心
const k = ref(5) // 质心


const handleReset = () => {
  initialKPoints();
  resetDataSource();
}

const initialKPoints = () => {
  kPoints.value = []
  for (let i = 0; i < parseInt(k.value); i++) {
    kPoints.value.push({
      id: guid_1(),
      x: random(0, showSize.width - 50),
      y: random(0, showSize.height - 50),
      color: COLORS[i % COLORS.length],
    })

    // 测试值
    // kPoints.value.push({
    //   id: guid_1(),
    //   x: 10 * i,
    //   y:  10 * i,
    //   color: COLORS[i % COLORS.length],
    // })
  }

}

const resetDataSource = () => {
  dataSource.value=[]
  for (let i = 0; i < dataSource_pointNum.value; i++) {
    dataSource.value.push({
      id: guid_1(),
      x: random(0, showSize.width - 10),
      y: random(0, showSize.height - 10),
      color: DEFAULT_COLOR,
      parent: null,
    })
  }
}

// 计算样本最近的一个k点
const calculateNearestKPoint = (point) => {
  let minBy = kPoints.value.map(kPoint=>{
    const {x, y} = kPoint
    const xOffset = Math.abs(x - point.x)
    const yOffset = Math.abs(y - point.y)
    return {
      ...kPoint,
      // sortNum 为sort的排序准备
      sortNum: Math.sqrt(xOffset ** 2 + yOffset ** 2)
    }
  }).sort((a,b) => {
    // 距离从小到大排序
    return a.sortNum - b.sortNum
  });
  // console.log('我要计算出来了__',bbb);

  // 返回距离最小的一个
  return minBy[0]
}

// 计算样本离哪个K点最近并进行分类
const handleStartCalculate = () => {
  dataSource.value.forEach(point=>{
    const nearestKPoint = calculateNearestKPoint(point)
    // console.log(nearestKPoint);
    point.color = nearestKPoint.color
    point.parent = nearestKPoint.id
  })

  // 临时测试值
  // calculateNearestKPoint({
  //   id: guid_1(),
  //   x: 10,
  //   y: 10,
  // })
}

// 根据样本点计算质心
const handleMoveKPoints = () => {
  kPoints.value.forEach(kPoint => {
    // 找质点旁边的所有点集合
    const children = dataSource.value.filter(point => point.parent === kPoint.id)

    // 求和 / 长度
    // 对 children 中所有x点,求和, 然后除以数组长度(即平均值)
    try {
      // 数组为空的时候异常,返回距离为0
      const sumX = children.map(point => point.x).reduce(function (total, item) {
        return total + item;
      })
      kPoint.x = sumX / children.length;
    } catch (e) {
      kPoint.x = 0;
    }


    try {
      const sumY = children.map(point => point.y).reduce(function (total, item3) {
        return total + item3;
      })
      kPoint.y = sumY / children.length;
    } catch (e) {
      kPoint.y = 0;
    }
  })
}

onMounted(()=>{
  handleReset()
})

</script>

<style scoped>
.fei-root {
  width: 100%;
  height: 100%;
}
.k-body {
  margin: 30px auto;
  width: 500px;
  height: 500px;
  position: relative;
  border: 1px solid #ff6b81;
}
.point {
  width: 10px;
  height: 10px;
  border-radius: 10px;
  position: absolute;
  opacity: 0.5;
}
.k-point {
  width: 25px;
  height: 25px;
  border-radius: 25px;
  position: absolute;
}
</style>


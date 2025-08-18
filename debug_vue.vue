<template>
  <div>
    <h1>{{ title }}</h1>
    <button @click="handleClick">Click me</button>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const title = ref('Hello Vue')

function handleClick() {
  console.log('clicked')
}
</script>

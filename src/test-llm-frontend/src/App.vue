<script setup>
import { ref } from 'vue';
import { test_llm_backend } from 'declarations/test-llm-backend/index';

let greeting = ref('');
let userInput = ref('');

async function handleSubmit(e) {
  e.preventDefault();
  try {
    const response = await test_llm_backend.greet(userInput.value);
    greeting.value = response;
  } catch (error) {
    console.error('Error calling backend:', error);
    greeting.value = 'Error: Could not get response from backend.';
  }
}
</script>

<template>
  <nav>
    <h1 class="site-title">Check-Bit</h1>
  </nav>
  <main>
    <div class="chat-box">
      <div class="user-input">
        <i class="bi bi-person-square"></i> <br>
        {{ userInput || 'This is example user input.' }}
      </div>
      <div class="bot-output">
        <i class="bi bi-stars"></i> <br>
        {{ greeting || 'This is example bot output.' }}
      </div>
    </div>
    <form class="bot-sending-prompt" @submit="handleSubmit">
      <textarea v-model="userInput"></textarea> <br>
      <button type="submit">Send prompt</button>
    </form>
  </main>
</template>

<style>
/* Opcjonalnie: Dodaj podstawowe style dla czytelności */
.chat-box {
  margin: 20px;
}
.user-input, .bot-output {
  padding: 10px;
  margin-bottom: 10px;
}
.bot-sending-prompt textarea {
  width: 100%;
  height: 100px;
}
</style>


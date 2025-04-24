<script lang="ts">
  import { onMount } from 'svelte';
  import * as webllm from "@mlc-ai/web-llm";

  let engine: webllm.MLCEngine | null = null;
  let jsonInput: string = '';
  let queryInput: string = '';
  let output: string = '';
  let errorMessage: string = '';
  let isModelAvailable: boolean = false;
  let downloadStatus: string = '';
  let progress: number = 0; // Progress percentage
  const selectedModel: string = 'Phi-3-mini-4k-instruct-q4f16_1-MLC';
  let userQuery: string = ''; // To store the user query for display
  let isThinking: boolean = false; // To indicate if the AI is processing the query
  let showModal: boolean = true; // State to control the modal visibility

  const clearContent = (): void => {
    jsonInput = '';
    queryInput = '';
    output = '';
    errorMessage = '';
    progress = 0;
    userQuery = '';
  };

  const updateProgress = (report: { progress: number; text: string }): void => {
    progress = Math.round(report.progress * 100); // Convert to percentage
    downloadStatus = report.text;
  };

  const initializeWebLLMEngine = async (): Promise<void> => {
    try {
      downloadStatus = 'Initializing model...';
      progress = 0;
      if (engine) {
        engine.setInitProgressCallback(updateProgress);
        await engine.reload(selectedModel, { temperature: 1.0, top_p: 1 });
        isModelAvailable = true; // Ensure this is set to true after successful initialization
        downloadStatus = 'Model initialized successfully.';
        progress = 0; // Reset progress after successful initialization
      }
    } catch (error: any) {
      console.error('Error initializing model:', error);
      errorMessage = error.message || 'Failed to initialize the model. Please try downloading it.';
      downloadStatus = '';
      progress = 0;
      isModelAvailable = false; // Ensure this is reset on failure
    }
  };

  const closeModal = async (): Promise<void> => {
    showModal = false;
    await initializeWebLLMEngine(); // Initialize the model only after the modal is closed
  };

  const formatJSON = (): void => {
    try {
      if (jsonInput.trim()) {
        const parsedJSON = JSON.parse(jsonInput); // Parse the JSON to validate it
        jsonInput = JSON.stringify(parsedJSON, null, 2); // Pretty format the JSON
        errorMessage = ''; // Clear any previous error messages
      }
    } catch (error) {
      errorMessage = 'Invalid JSON format. Please correct it.';
    }
  };

  const downloadModel = async (): Promise<void> => {
    try {
      downloadStatus = 'Downloading model...';
      progress = 0;
      await initializeWebLLMEngine();
    } catch (error: any) {
      console.error('Error downloading the model:', error);
      errorMessage = error.message || 'Failed to download the model. Please try again.';
      downloadStatus = '';
      progress = 0;
    }
  };

  async function handleTalk(): Promise<void> {
    if (!jsonInput.trim()) {
      errorMessage = 'Please enter some JSON to discuss.';
      return;
    }

    if (!queryInput.trim()) {
      errorMessage = 'Please enter a query to ask about the JSON.';
      return;
    }

    if (engine) {
      try {
        userQuery = queryInput; // Store the user query
        output = ''; // Clear the old AI response
        isThinking = true; // Set thinking state to true
        const messages: webllm.ChatCompletionMessageParam[] = [
          {
            role: 'system',
            content: `You are a helpful assistant for JSON-related queries. 
            Respond in a single word or sentence only. 
            Understand the JSON structure and provide relevant information based on the user's query.`,
          },
          { role: 'user', content: `JSON: ${jsonInput}\nQuery: ${queryInput}` },
        ];
        const reply = await engine.chat.completions.create({ messages });
        const rawOutput = reply.choices[0]?.message?.content || '';
        output = rawOutput; // Format the output
        queryInput = ''; // Clear the user query input field
        errorMessage = ''; // Clear any previous error messages
      } catch (error: any) {
        console.error('Error during chat completion:', error);
        errorMessage = error.message || 'An error occurred while processing your query.';
      } finally {
        isThinking = false; // Reset thinking state
      }
    }
  }

  onMount(async (): Promise<void> => {
    try {
      engine = new webllm.MLCEngine();
    } catch (error: any) {
      console.error('Error initializing WebLLM:', error);
      errorMessage = 'Failed to initialize the engine.';
    }
  });
</script>

<div class="container mt-3">
  {#if showModal}
    <div class="modal show d-block" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Important Information</h5>
      
            <button type="button" class="btn-close" aria-label="Close" on:click={closeModal}></button>
          </div>
          
          <div class="modal-body">
            <p>
              <strong>Please read the following details carefully</strong>
            </p>
            <p>
              The <strong>{selectedModel}</strong> is a lightweight AI model. 
              It requires approximately <strong>4GB of RAM</strong> with GPU acceleration for optimal performance. 
              The model has been tested on a <strong>Mac M4 with 16GB RAM</strong>.
            </p>
            <p>
              Below are the key informations about the model:
            </p>
            <ul>
              <li><strong>Model Name:</strong> Phi-3 Mini Instruct</li>
              <li><strong>Parameters:</strong> 3.8B</li>
              <li><strong>Architecture:</strong> Transformer</li>
              <li><strong>Token Limit:</strong> 4096</li>
              <li><strong>Quantization:</strong> 4-bit quantization format with 16-bit floating-point weights, balancing reduced memory usage with maintained performance</li>
            </ul>
            <p>
              Please ensure your system meets the minimum requirements before running this application. 
              Running the model on systems with insufficient resources may lead to performance issues.
            </p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" on:click={closeModal}>Got it</button>
          </div>
        </div>
      </div>
    </div>
  {/if}

  <div class="row" style="height: calc(100vh - 100px);">
    <div class="col-md-6 d-flex flex-column">
      <h3>JSON</h3>
      <textarea
        class="form-control flex-grow-1"
        bind:value={jsonInput}
        placeholder="Paste your JSON here to talk about or extract information from that using AI..."
        on:input={formatJSON}
      ></textarea>
    </div>
    <div class="col-md-6 d-flex flex-column">
      <h3>Enter Query</h3>
      <div class="mb-3 alert alert-info">
        <p><strong>Current Model:</strong> {selectedModel}</p>
        <p><strong>Status:</strong> {downloadStatus || 'Not initialized'}</p>
      </div>
      <textarea
        class="form-control mb-3"
        bind:value={queryInput}
        placeholder="Enter your query about the JSON"
      ></textarea>
      <div class="mb-3">
        <button on:click={handleTalk} class="btn btn-primary btn-sm me-2" disabled={!isModelAvailable || isThinking}>
          Ask AI
        </button>
        <button on:click={clearContent} class="btn btn-secondary btn-sm">Reset</button>
        {#if !isModelAvailable}
          <button on:click={downloadModel} class="btn btn-warning btn-sm ms-2">Download & Initialize Model</button>
        {/if}
      </div>
      {#if progress > 0}
        <div class="progress">
          <div
            class="progress-bar"
            role="progressbar"
            style="width: {progress}%"
            aria-valuenow={progress}
            aria-valuemin="0"
            aria-valuemax="100"
          >
            {progress}%
          </div>
        </div>
      {/if}
      {#if errorMessage}
        <div class="alert alert-danger" role="alert">{errorMessage}</div>
      {/if}
      {#if userQuery}
        <div class="mt-3">
          <p><strong>You asked:</strong> {userQuery}</p>
          {#if isThinking}
            <p><strong>AI response:</strong> <em>Thinking...</em></p>
          {:else}
            <p><strong>AI response:</strong> {@html output} <!-- Render the formatted output as HTML --></p>
          {/if}
        </div>
      {/if}
    </div>
  </div>
</div>

<style>
  textarea {
    font-size: 0.9rem;
    font-family: 'PT Mono';
    resize: none;
    width: 100%;
  }
  .formatted-json {
    font-size: 0.9rem;
    font-family: 'PT Mono';
    background-color: #f8f9fa;
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    white-space: pre-wrap;
    word-wrap: break-word;
    overflow-y: auto;
  }
  .alert {
    font-size: 0.9rem;
    margin-bottom: 1rem;
  }
  .progress {
    height: 20px;
    margin-top: 10px;
  }
  .progress-bar {
    background-color: #007bff;
  }
  .container {
    max-width: 100%;
  }
  .modal {
    background-color: rgba(0, 0, 0, 0.5);
  }
  .modal-content {
    font-size: 0.9rem;
  }
</style>
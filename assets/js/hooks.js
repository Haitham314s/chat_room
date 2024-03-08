let Hooks = {};

Hooks.UpdateLineNumbers = {
  mounted() {
    this.el.addEventListener("input", () => {
      this.updateLineNumbers();
    });

    this.updateLineNumbers();
  },

  updateLineNumbers() {
    const lineNumberText = document.querySelector("#line-numbers");
    if (!lineNumberText) return;

    const lines = this.el.value.split("\n");
    const numbers = lines.map((_, index) => index + 1).join("\n") + "\n";

    lineNumberText.value = numbers;
  },
};

export default Hooks;

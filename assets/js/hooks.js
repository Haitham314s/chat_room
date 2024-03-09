let Hooks = {};

Hooks.UpdateLineNumbers = {
  mounted() {
    const lineNumberText = document.querySelector("#line-numbers");
    this.el.addEventListener("input", () => {
      this.updateLineNumbers();
    });

    this.el.addEventListener("scroll", () => {
      lineNumberText.scrollTop = this.el.scrollTop;
    });

    this.handleEvent("clear-textareas", () => {
      this.el.value = "";
      lineNumberText.value = "1\n";
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

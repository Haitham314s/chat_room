import hljs from "highlight.js";

type CodeBlock = HTMLElement | null;

const Highlight = {
  mounted() {
    const name = this.el.getAttribute("data-name");
    const codeBlock: CodeBlock = this.el.querySelector("pre code");

    if (name && codeBlock) {
      codeBlock.className = codeBlock.className.replace(/language-\S+/g, "");
      codeBlock.classList.add(`language-${this.getSyntaxType(name)}`);
      hljs.highlightElement(codeBlock);
    }
  },

  getSyntaxType(name) {
    let extension = name.split(".").pop();

    switch (extension) {
      case "txt":
        return "text";
      case "json":
        return "json";
      case "html":
        return "html";
      case "heex":
        return "html";
      case "js":
        return "javascript";
      default:
        return "elixir";
    }
  },
};

export default Highlight;

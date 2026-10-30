const RESET_AFTER = 2000;

document.querySelectorAll(".copy").forEach((button) => {
  if (!navigator.clipboard) return;

  const status = button.nextElementSibling;
  let timer;

  button.hidden = false;
  button.addEventListener("click", async () => {
    await navigator.clipboard.writeText(button.dataset.copy);

    button.classList.add("copied");
    status.textContent = button.dataset.copied;
    clearTimeout(timer);
    timer = setTimeout(() => {
      button.classList.remove("copied");
      status.textContent = "";
    }, RESET_AFTER);
  });
});

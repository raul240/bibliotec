document.getElementById("recuperar-form").addEventListener("submit", async (e) => {
    e.preventDefault();

    const email = document.getElementById("email").value;
    const novaSenha = document.getElementById("novaSenha").value;

    const response = await fetch("http://localhost:3000/recuperar", {
        method: "PUT",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ email, novaSenha })
    });

    const data = await response.json();

    if (response.ok) {
        alert("Senha alterada com sucesso!");
        window.location.href = "../index.html";
    } else {
        alert(data.erro);
    }
});


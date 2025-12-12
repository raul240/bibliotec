document.getElementById("login-form").addEventListener("submit", async (e) => {
    e.preventDefault();

    const email = document.getElementById("email").value;
    const senha = document.getElementById("senha").value;

    try {
        const response = await fetch("http://localhost:3000/login", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ email, senha })
        });

        const data = await response.json();

        if (response.ok) {
            // salvar token
            localStorage.setItem("token", data.token);

            // ir para a página secreta
            window.location.href = "pages/teste.html";
        } else {
            alert(data.erro);
        }
    } catch (error) {
        console.error("Erro:", error);
    }
});



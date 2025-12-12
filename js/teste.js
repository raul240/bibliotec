(async () => {
    const token = localStorage.getItem("token");

    if (!token) {
        alert("Você não está logado!");
        window.location.href = "../index.html";
        return;
    }

    const response = await fetch("http://localhost:3000/teste", {
        headers: { "Authorization": token }
    });

    if (!response.ok) {
        alert("Sessão inválida! Faça login novamente.");
        window.location.href = "../index.html";
    }
})();

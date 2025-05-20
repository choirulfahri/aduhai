<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(10px); }
            to { opacity: 1; transform: translateX(0); }
        }
        .tab-content {
            animation: slideIn 0.3s ease-out forwards;
        }
        .btn-hover {
            transition: all 0.3s ease;
        }
        .btn-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        .btn-hover:active {
            transform: translateY(0);
        }
        input:focus {
            outline: none;
            border-color: #1e40af;
            box-shadow: 0 0 5px rgba(30, 64, 175, 0.5);
        }
    </style>
</head>
<body class="bg-blue-400 flex items-center justify-center min-h-screen">
    <div class="bg-white p-6 rounded-lg shadow-lg w-full max-w-md">
        <h2 class="text-xl font-semibold text-gray-700 text-center mb-4">Welcome Back</h2>
        <p class="text-gray-600 text-center mb-6">Welcome Back, Please enter your details</p>

        <!-- Tab Navigation -->
        <div class="flex justify-between mb-4">
            <button id="signInTab" class="w-1/2 py-2 bg-gray-300 text-gray-700 font-medium rounded-l-md btn-hover">Sign In</button>
            <button id="signUpTab" class="w-1/2 py-2 bg-blue-800 text-white font-medium rounded-r-md btn-hover">Sign Up</button>
        </div>

        <!-- Sign In Form -->
        <div id="signInForm" class="tab-content">
            <form action="log.jsp" method="post">
                <div class="mb-4 flex items-center border border-gray-300 rounded-md p-2 bg-white">
                    <span class="text-gray-500 mr-2">@</span>
                    <input type="email" name="email" class="w-full p-1 border-none focus:outline-none" placeholder="exampleemail23@gmail.com" required>
                </div>
                <div class="mb-4 flex items-center border border-gray-300 rounded-md p-2 bg-white">
                    <span class="text-gray-500 mr-2">🔒</span>
                    <input type="password" name="password" class="w-full p-1 border-none focus:outline-none" placeholder="Password" required>
                </div>
                <button type="submit" class="w-full py-2 bg-blue-800 text-white rounded-md mb-4 btn-hover">Continue</button>
                <% if (session.getAttribute("errorMessage") != null) { %>
                    <p class="text-red-500 text-center"><%= session.getAttribute("errorMessage") %></p>
                    <% session.removeAttribute("errorMessage"); %>
                <% } %>
            </form>
            <div class="text-center text-gray-600 mb-4">Or Continue With</div>
            <div class="flex justify-center space-x-4">
                <img src="https://www.google.com/favicon.ico" alt="Google" class="w-8 h-8">
                <img src="https://www.google.com/favicon.ico" alt="Google" class="w-8 h-8">
                <img src="https://www.google.com/favicon.ico" alt="Google" class="w-8 h-8">
            </div>
        </div>

        <!-- Sign Up Form -->
        <div id="signUpForm" class="tab-content hidden">
            <form action="reg.jsp" method="get">
                <div class="mb-4 flex items-center border border-gray-300 rounded-md p-2 bg-white">
                    <span class="text-gray-500 mr-2">👤</span>
                    <input type="text" name="username" class="w-full p-1 border-none focus:outline-none" placeholder="Username" required>
                </div>
                <div class="mb-4 flex items-center border border-gray-300 rounded-md p-2 bg-white">
                    <span class="text-gray-500 mr-2">@</span>
                    <input type="email" name="email" class="w-full p-1 border-none focus:outline-none" placeholder="exampleemail23@gmail.com" required>
                </div>
                <div class="mb-4 flex items-center border border-gray-300 rounded-md p-2 bg-white">
                    <span class="text-gray-500 mr-2">🔒</span>
                    <input type="password" name="password" class="w-full p-1 border-none focus:outline-none" placeholder="Password" required>
                </div>
                <button type="submit" class="w-full py-2 bg-blue-800 text-white rounded-md mb-4 btn-hover">Continue</button>
            </form>
            <div class="text-center text-gray-600 mb-4">Or Continue With</div>
            <div class="flex justify-center space-x-4">
                <img src="https://www.google.com/favicon.ico" alt="Google" class="w-8 h-8">
                <img src="https://www.google.com/favicon.ico" alt="Google" class="w-8 h-8">
                <img src="https://www.google.com/favicon.ico" alt="Google" class="w-8 h-8">
            </div>
        </div>
    </div>

    <script>
        const signInTab = document.getElementById('signInTab');
        const signUpTab = document.getElementById('signUpTab');
        const signInForm = document.getElementById('signInForm');
        const signUpForm = document.getElementById('signUpForm');

        signInTab.addEventListener('click', () => {
            signInTab.classList.add('bg-gray-300', 'text-gray-700');
            signInTab.classList.remove('bg-blue-800', 'text-white');
            signUpTab.classList.add('bg-blue-800', 'text-white');
            signUpTab.classList.remove('bg-gray-300', 'text-gray-700');
            signInForm.classList.remove('hidden');
            signUpForm.classList.add('hidden');
        });

        signUpTab.addEventListener('click', () => {
            signUpTab.classList.add('bg-gray-300', 'text-gray-700');
            signUpTab.classList.remove('bg-blue-800', 'text-white');
            signInTab.classList.add('bg-blue-800', 'text-white');
            signInTab.classList.remove('bg-gray-300', 'text-gray-700');
            signUpForm.classList.remove('hidden');
            signInForm.classList.add('hidden');
        });
    </script>
</body>
</html>
import { useState } from "react"
import { LoginForm } from "@/components/login-form"
import { SignupForm } from "@/components/signup-form"

function App() {
  // state pour savoir si on affiche le login (true) ou l'inscription (false)
  const [isLogin, setIsLogin] = useState(true)

  return (
    <main className="min-h-screen w-full flex items-center justify-center bg-background p-4">
      <div className="w-full max-w-sm">
        {isLogin ? (
          /* Affiche LoginForm si isLogin est true */
          <LoginForm onSwitchToSignup={() => setIsLogin(false)} />
        ) : (
          /* Affiche SignupForm si isLogin est false */
          <SignupForm onSwitchToSignIn={() => setIsLogin(true)} />
        )}
      </div>
    </main>
  )
}

export default App

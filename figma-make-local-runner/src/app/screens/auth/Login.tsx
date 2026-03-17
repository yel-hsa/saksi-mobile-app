import { useNavigate, useSearchParams } from "react-router-dom";
import { ArrowLeft } from "lucide-react";

export function Login() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const role = searchParams.get("role") || "resident";

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    if (role === "resident") {
      navigate("/setup");
    } else {
      navigate("/official");
    }
  };

  return (
    <div className="min-h-screen bg-white text-black font-sans px-6 py-12 flex flex-col relative">
      <button 
        onClick={() => navigate(-1)} 
        className="absolute top-6 left-6 p-2 rounded-full hover:bg-gray-100 transition-colors"
        aria-label="Go back"
      >
        <ArrowLeft className="w-6 h-6" />
      </button>

      <div className="flex-1 flex flex-col justify-center max-w-sm mx-auto w-full pt-16">
        <h1 className="text-3xl font-black mb-2">Welcome Back</h1>
        <p className="text-[#333333] mb-10">
          Please log in to your SAKSI account.
        </p>

        <form onSubmit={handleLogin} className="flex flex-col gap-6">
          <div className="flex flex-col gap-2">
            <label className="text-sm font-bold text-[#333333]" htmlFor="email">
              Email Address
            </label>
            <input
              id="email"
              type="email"
              required
              placeholder="juan@delacruz.com"
              className="w-full border-b-2 border-gray-300 py-3 text-lg focus:border-black outline-none transition-colors"
            />
          </div>

          <div className="flex flex-col gap-2">
            <label className="text-sm font-bold text-[#333333]" htmlFor="password">
              Password
            </label>
            <input
              id="password"
              type="password"
              required
              placeholder="••••••••"
              className="w-full border-b-2 border-gray-300 py-3 text-lg focus:border-black outline-none transition-colors"
            />
          </div>

          <button
            type="submit"
            className="w-full bg-[#D32F2F] text-white font-bold py-4 rounded-xl shadow-lg mt-8 active:scale-95 transition-transform"
          >
            Sign In
          </button>
        </form>
      </div>
    </div>
  );
}

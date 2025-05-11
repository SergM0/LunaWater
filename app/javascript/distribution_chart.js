import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer } from "recharts";

document.addEventListener("DOMContentLoaded", () => {
    const element = document.getElementById("distribution-chart");

    if (element) {
        const fetchData = async () => {
            const response = await fetch("/dashboard/distribucion");
            const data = await response.json();

            const totalVolumen = data.reduce((acc, medicion) => acc + medicion.volumen_m3, 0).toFixed(3);

            const container = document.createElement("div");
            container.style.width = "100%";
            container.style.height = "400px";
            element.appendChild(container);

            const chart = (
                <ResponsiveContainer width="100%" height={400}>
                    <PieChart>
                        <Pie
                            data={data}
                            dataKey="volumen_m3"
                            nameKey="nombre_sensor"
                            cx="50%"
                            cy="50%"
                            innerRadius={100}
                            outerRadius={150}
                            fill="#8884d8"
                            label={({ name, value }) => `${name} ${value.toFixed(3)} m³`}
                        >
                            {data.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={["#00C49F", "#0088FE", "#FFBB28", "#FF8042", "#A569BD", "#17A2B8", "#E74C3C", "#3498DB", "#1ABC9C", "#9B59B6"][index % 10]} />
                            ))}
                        </Pie>
                        <Tooltip formatter={(value) => `${value.toFixed(3)} m³`} />
                        <text x="50%" y="50%" textAnchor="middle" dominantBaseline="middle" className="fs-4 fw-bold">
                            {totalVolumen} m³
                        </text>
                    </PieChart>
                </ResponsiveContainer>
            );

            ReactDOM.createRoot(container).render(chart);
        };

        fetchData();
    }
});

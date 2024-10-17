const destinations = [
    {
      title: "Petra",
      description: "Petra, often referred to as the \"Rose City\" due to the color of its rock-cut architecture, is one of Jordan's most iconic landmarks. This ancient Nabatean city, carved into the red sandstone cliffs, is renowned for its stunning rock formations and archaeological marvels. Key highlights include the Treasury (Al-Khazneh), the Monastery (Ad-Deir), and the ancient city’s intricate water conduit system.",
      images: [
        require("./image/petra1.jpeg"),
        require("./image/petra2.jpeg"),
        require("./image/petra3.jpeg"),
        require("./image/petra4.jpeg"),
        require("./image/petra5.jpeg")
      ]
    },
    {
      title: "Wadi Rum",
      description: "Known as the \"Valley of the Moon,\" Wadi Rum is a vast desert landscape characterized by its dramatic sandstone mountains, deep canyons, and unique rock formations. Visitors can experience thrilling jeep tours, camel rides, and overnight stays in traditional Bedouin-style camps, immersing themselves in the stunning, otherworldly terrain.",
      images: [
        require("./image/Wadi Rum1.jpeg"),
        require("./image/Wadi Rum2.jpg"),
        require("./image/Wadi Rum3.jpg"),
        require("./image/Wadi Rum4.jpg"),
        require("./image/Wadi Rum5.jpg")
      ]
    },
    {
      title: "Dead Sea",
      description: "The Dead Sea, the lowest point on Earth's surface, is famous for its hypersaline waters that allow visitors to float effortlessly. The mineral-rich mud is also known for its therapeutic properties. The surrounding area offers luxurious resorts and stunning views of the surrounding landscape, making it a perfect spot for relaxation and wellness.",
      images: [
        require("./image/Dead Sea1.jpeg"),
        require("./image/Dead Sea2.jpg"),
        require("./image/Dead Sea3.jpg"),
        require("./image/Dead Sea4.jpg"),
        require("./image/Dead Sea5.jpg")
      ]
    },
    {
      title: "Amman",
      description: "Jordan’s vibrant capital, Amman, combines modernity with historical charm. Key attractions include the Citadel, which offers panoramic views of the city and houses the ancient Temple of Hercules and the Umayyad Palace. The Roman Theater, a well-preserved ancient amphitheater, provides insight into the city’s rich past.",
      images: [
        require("./image/Amman1.jpeg"),
        require("./image/Amman2.jpg"),
        require("./image/Amman3.jpg"),
        require("./image/Amman4.jpg"),
        require("./image/Amman5.jpg")
      ]
    },
    {
      title: "Jerash",
      description: "Often referred to as the \"Pompeii of the East,\" Jerash is renowned for its well-preserved Roman ruins. Highlights include the Oval Plaza, the Temple of Artemis, and the impressive Hadrian's Arch. The ancient city's layout and structures offer a fascinating glimpse into Roman urban planning and architecture.",
      images: [
        require("./image/Jerash1.jpeg"),
        require("./image/Jerash2.jpeg"),
        require("./image/Jerash3.jpeg"),
        require("./image/Jerash4.jpeg"),
        require("./image/Jerash5.jpeg")
      ]
    },
    {
      title: "Ajloun",
      description: "Ajloun is known for its medieval Ajloun Castle, built by the Ayyubid ruler Salah ad-Din. The castle offers stunning views of the surrounding countryside and provides insight into the region’s historical military significance. The nearby forested hills are ideal for nature walks and exploring local flora and fauna.",
      images: [
        require("./image/Ajloun1.jpg"),
        require("./image/Ajloun2.jpg"),
        require("./image/Ajloun3.jpg"),
        require("./image/Ajloun4.jpg"),
        require("./image/Ajloun5.jpg")
      ]
    },
    {
      title: "Mount Nebo",
      description: "Mount Nebo is a significant religious site, believed to be the place where Moses viewed the Promised Land before his death. The summit offers breathtaking views of the Jordan Valley, the Dead Sea, and even Jerusalem on clear days. The site also features ancient mosaics and a modern church.",
      images: [
        require("./image/Mount Nebo1.jpeg"),
        require("./image/Mount Nebo2.jpg"),
        require("./image/Mount Nebo3.jpg"),
        require("./image/Mount Nebo4.jpg"),
        require("./image/Mount Nebo5.jpg")
      ]
    },
    {
      title: "Aqaba",
      description: "Aqaba, Jordan’s premier beach destination, is located on the Red Sea coast. Known for its warm, clear waters and vibrant marine life, it is a haven for water sports enthusiasts and divers. The city also offers a range of luxury resorts, shopping opportunities, and cultural experiences.",
      images: [
        require("./image/Aqaba1.jpeg"),
        require("./image/Aqaba2.jpeg"),
        require("./image/Aqaba3.jpeg"),
        require("./image/Aqaba4.jpeg"),
        require("./image/Aqaba5.jpg")
      ]
    },
    {
      title: "Karak",
      description: "Karak, a historic city in southern Jordan, is renowned for the imposing Karak Castle, a massive Crusader fortress built in the 12th century. The castle offers panoramic views of the surrounding countryside and provides insight into the region’s medieval history. The town of Karak itself is known for its charming souks and traditional Jordanian cuisine.",
      images: [
        require("./image/Karak1.jpg"),
        require("./image/Karak2.jpg"),
        require("./image/Karak3.jpg"),
        require("./image/Karak4.jpg"),
        require("./image/Karak5.jpg")
      ]
    },
    {
      title: "Hammamat Ma’in",
      description: "Hammamat Ma’in, also known as Ma'in Hot Springs, is a natural hot springs resort located in the Ma’in Mountains. The mineral-rich thermal waters, cascading waterfalls, and scenic views make it a popular destination for relaxation and therapeutic treatments. The area features a range of luxurious spa facilities and is ideal for unwinding amidst nature.",
      images: [
        require("./image/Hammamat Ma’in1.jpg"),
        require("./image/Hammamat Ma’in2.jpg"),
        require("./image/Hammamat Ma’in3.jpg"),
        require("./image/Hammamat Ma’in4.jpg"),
        require("./image/Hammamat Ma’in5.jpg")
      ]
    }
    ,
    {
      title: "Madaba",
      description: "Madaba is a combination of rural home life and a hot spot for religious tourism. Known as the “City of Mosaics” Madaba is the cultural epicenter for Byzantine and Umayyad mosaics. Just a short distance from the capitol visitors are just a stone's throw away from the holy monuments of religious iconography.",
      images: [
        require("./image/Madaba1.jpg"),
        require("./image/Madaba2.jpg"),
        require("./image/Madaba3.jpg"),
        require("./image/Madaba4.jpg"),
        require("./image/Madaba5.jpg")
      ]
    },
    {
      title: "Um Qais",
      description: "Site of the famous miracle of the Gadarene swine, Gadara was renowned in its time as a cultural centre. It was the home of several classical poets and philosophers, including Theodorus, founder of a rhetorical school in Rome, and was once called “a new Athens” by a poet. Perched on a splendid hilltop overlooking the Jordan Valley and the Sea of Galilee, Gadara is known today as Umm Qais, and boasts an impressive colonnaded street, a vaulted terrace, and the ruins of two theatres.",
      images: [
        require("./image/Um Qais1.jpg"),
        require("./image/Um Qais2.jpg"),
        require("./image/Um Qais3.jpg"),
        require("./image/Um Qais4.jpg"),
        require("./image/Um Qais5.jpg"),

      ]
    }
  ];
  export default destinations
import 'package:flutter/material.dart';
import 'package:namma_bus/conponents/search.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TimingsScreen extends StatefulWidget {
  const TimingsScreen({super.key});

  @override
  State<TimingsScreen> createState() => _TimingsScreenState();
}

class _TimingsScreenState extends State<TimingsScreen> {
  @override
  void initState() {
    super.initState();
    fetchBusSchedule(); // Fetch bus schedule on initialization
  }

  late List<Bus> _busSchedule = [];

  Future<void> fetchBusSchedule() async {
    final currentTime = DateTime.now();
    final currentTimeString = DateFormat('HH:mm').format(currentTime);

    final responseBusSchedule = await supabase
        .from('buses_from_nitte')
        .select('*')
        .gte('Time', currentTimeString);

    final List<Bus> busList = [];
    final List<dynamic> busData = responseBusSchedule;
    for (var rawData in busData) {
      final bus = Bus.fromMap(rawData);
      busList.add(bus);
    }

    setState(() {
      _busSchedule = busList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Search(),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(20),
            child: ListView.separated(
              itemCount: _busSchedule.length,
              itemBuilder: (context, index) {
                final bus = _busSchedule[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(bus.name),
                      Text(bus.time),
                    ],
                  ),
                  subtitle: Text(
                    '${bus.type} to ${bus.destination}',
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey[300],
                  height: 1.0,
                  indent: 20,
                  endIndent: 20,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class Bus {
  final String time;
  final String name;
  final String type;
  final String destination;

  Bus({
    required this.time,
    required this.name,
    required this.type,
    required this.destination,
  });

  factory Bus.fromMap(Map<String, dynamic> data) {
    return Bus(
      time: data['Time'] ?? '',
      name: data['Name'] ?? '',
      type: data['Type'] ?? '',
      destination: data['Destination'] ?? '',
    );
  }
}

final supabase = Supabase.instance.client;
